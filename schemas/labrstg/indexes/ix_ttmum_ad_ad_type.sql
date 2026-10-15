-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrstg.labrstg_ad USING btree (ad_type);


--
