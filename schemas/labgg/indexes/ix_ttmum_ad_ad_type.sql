-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labgg.labgg_ad USING btree (ad_type);


--
