-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labuww.labuww_ad USING btree (ad_type);


--
