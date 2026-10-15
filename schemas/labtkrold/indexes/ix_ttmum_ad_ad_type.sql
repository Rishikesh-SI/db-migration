-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labtkrold; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labtkrold.labtkr_ad USING btree (ad_type);


--
