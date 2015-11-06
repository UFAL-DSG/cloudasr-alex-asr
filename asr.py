from math import *
from kaldi2.utils import lattice_to_nbest, wst2dict
from kaldi2.decoders import cPyKaldi2Decoder
from asr_utils import lattice_calibration

def create_asr():
    import config
    

    recogniser = cPyKaldi2Decoder(config.model_path)

    return ASR(recogniser)

class ASR:

    def __init__(self, recogniser):
        self.recogniser = recogniser
        self.decoded_frames = 0
        self.callbacks = []

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def recognize_chunk(self, chunk):
        self.recogniser.frame_in(chunk)
        dec_t = self.recogniser.decode(max_frames=10)
        while dec_t > 0:
            self.call_callbacks()

            self.decoded_frames += dec_t
            dec_t = self.recogniser.decode(max_frames=10)

        if self.decoded_frames == 0:
            return (1.0, '')
        else:
            p, interim_result = self.recogniser.get_best_path()
            return p, self._tokens_to_words(interim_result)

    def _tokens_to_words(self, tokens):
        print tokens
        return " ".join([self.recogniser.get_word(x).decode('utf8') for x in tokens])

    def get_final_hypothesis(self):
        if self.decoded_frames == 0:
            return [(1.0, '')]

        self.recogniser.finalize_decoding()
        utt_lik, lat = self.recogniser.get_lattice()
        self.reset()

        return self._to_nbest(lat, 10)

    def _to_nbest(self, lattice, n):
        return [(exp(-prob), self._tokens_to_words(path)) for (prob, path) in lattice_to_nbest(lattice_calibration(lattice), n=n)]

    def change_lm(self, lm):
        pass

    def reset(self):
        self.decoded_frames = 0
        self.recogniser.reset()

    def call_callbacks(self):
        for callback in self.callbacks:
            callback()
