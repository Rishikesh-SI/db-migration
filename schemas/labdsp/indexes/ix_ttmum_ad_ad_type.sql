-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labdsp; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labdsp.labdsp_ad USING btree (ad_type);


--
