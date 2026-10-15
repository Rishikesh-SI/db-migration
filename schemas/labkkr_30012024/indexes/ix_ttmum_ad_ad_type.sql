-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labkkr_30012024.labkkr_ad USING btree (ad_type);


--
