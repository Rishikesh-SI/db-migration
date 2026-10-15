-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labgfg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labgfg.labgfg_ad USING btree (ad_type);


--
