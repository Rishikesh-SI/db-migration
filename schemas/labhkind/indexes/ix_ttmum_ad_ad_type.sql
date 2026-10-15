-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labhkind.labhkind_ad USING btree (ad_type);


--
