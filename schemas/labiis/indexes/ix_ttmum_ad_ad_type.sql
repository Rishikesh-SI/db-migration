-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labiis; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labiis.labiis_ad USING btree (ad_type);


--
