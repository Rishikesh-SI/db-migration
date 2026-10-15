-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labman; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labman.labman_ad USING btree (ad_type);


--
