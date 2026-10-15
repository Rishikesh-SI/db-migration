-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labtkr; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labtkr.labtkr_ad USING btree (ad_type);


--
