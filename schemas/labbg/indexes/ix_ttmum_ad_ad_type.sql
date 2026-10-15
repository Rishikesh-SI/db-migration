-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labbg.labbg_ad USING btree (ad_type);


--
