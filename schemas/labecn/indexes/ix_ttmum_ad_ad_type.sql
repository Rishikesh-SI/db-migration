-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labecn; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labecn.labecn_ad USING btree (ad_type);


--
