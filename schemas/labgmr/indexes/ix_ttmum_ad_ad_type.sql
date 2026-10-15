-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labgmr.labgmr_ad USING btree (ad_type);


--
