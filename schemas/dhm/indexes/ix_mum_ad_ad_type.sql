-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_ad_ad_type
-- Type: INDEX

-- Name: ix_mum_ad_ad_type; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_ad_ad_type ON dhm.dhm_ad USING btree (ad_type);


--
