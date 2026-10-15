-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrs_2602.labrs_ad USING btree (ad_type);


--
