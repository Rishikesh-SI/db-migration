-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrg; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrg.labrg_ad USING btree (ad_type);


--
