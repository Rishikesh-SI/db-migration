-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labboost.labboost_ad USING btree (ad_type);


--
