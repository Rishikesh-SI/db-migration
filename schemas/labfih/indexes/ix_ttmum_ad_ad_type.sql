-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labfih.labfih_ad USING btree (ad_type);


--
