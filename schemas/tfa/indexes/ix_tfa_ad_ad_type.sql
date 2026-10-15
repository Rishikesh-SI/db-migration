-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_ad_ad_type
-- Type: INDEX

-- Name: ix_tfa_ad_ad_type; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_ad_ad_type ON tfa.tfa_ad USING btree (ad_type);


--
