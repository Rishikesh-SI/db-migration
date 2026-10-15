-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labirao.labirao_ad USING btree (ad_type);


--
