-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labdv.labdv_ad USING btree (ad_type);


--
