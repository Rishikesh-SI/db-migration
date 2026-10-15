-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labyho.labyho_ad USING btree (ad_type);


--
