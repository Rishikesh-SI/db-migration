-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labpvl.labpvl_ad USING btree (ad_type);


--
