-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labrr_beta_08042024.labrr_ad USING btree (ad_type);


--
