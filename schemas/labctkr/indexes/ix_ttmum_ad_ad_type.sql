-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labctkr.labctkr_ad USING btree (ad_type);


--
