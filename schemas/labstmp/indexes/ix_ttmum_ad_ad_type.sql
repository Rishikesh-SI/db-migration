-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labstmp.labstmp_ad USING btree (ad_type);


--
