-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labkiyg.labkiyg_ad USING btree (ad_type);


--
