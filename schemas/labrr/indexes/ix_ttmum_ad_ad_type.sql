-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrr.labrr_ad USING btree (ad_type);


--
