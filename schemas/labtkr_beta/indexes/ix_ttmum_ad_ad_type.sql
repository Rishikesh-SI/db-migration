-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labtkr_beta; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labtkr_beta.labtkr_ad USING btree (ad_type);


--
