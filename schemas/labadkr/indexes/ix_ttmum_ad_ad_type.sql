-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labadkr.labadkr_ad USING btree (ad_type);


--
