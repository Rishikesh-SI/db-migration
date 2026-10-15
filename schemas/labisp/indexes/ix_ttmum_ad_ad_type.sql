-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labisp.labisp_ad USING btree (ad_type);


--
