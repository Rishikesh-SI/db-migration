-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labstrd; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labstrd.labstrd_ad USING btree (ad_type);


--
