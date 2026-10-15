-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labukk; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labukk.labukk_ad USING btree (ad_type);


--
