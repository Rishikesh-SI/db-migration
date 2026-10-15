-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrs; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrs.labrs_ad USING btree (ad_type);


--
