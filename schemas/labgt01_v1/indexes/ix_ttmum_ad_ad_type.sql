-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labgt01_v1.labgt01_v1_ad USING btree (ad_type);


--
