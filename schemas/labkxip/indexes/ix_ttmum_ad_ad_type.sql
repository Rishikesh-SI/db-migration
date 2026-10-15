-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labkxip.labkxip_ad USING btree (ad_type);


--
