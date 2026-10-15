-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labets.labets_ad USING btree (ad_type);


--
