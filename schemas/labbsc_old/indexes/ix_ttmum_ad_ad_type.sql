-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labbsc_old.labbsc_ad USING btree (ad_type);


--
