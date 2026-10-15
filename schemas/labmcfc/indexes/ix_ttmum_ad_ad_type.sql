-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labmcfc.labmcfc_ad USING btree (ad_type);


--
