-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_ad_ad_type
-- Type: INDEX

-- Name: ix_cfc_ad_ad_type; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_ad_ad_type ON cfc.cfc_ad USING btree (ad_type);


--
