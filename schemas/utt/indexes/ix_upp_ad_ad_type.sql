-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_ad_ad_type
-- Type: INDEX

-- Name: ix_upp_ad_ad_type; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_ad_ad_type ON utt.utt_ad USING btree (ad_type);


--
