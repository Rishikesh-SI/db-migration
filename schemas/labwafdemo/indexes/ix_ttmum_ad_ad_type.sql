-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labwafdemo; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labwafdemo.labwafdemo_ad USING btree (ad_type);


--
