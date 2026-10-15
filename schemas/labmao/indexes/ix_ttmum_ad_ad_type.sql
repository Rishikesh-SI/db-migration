-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: ix_ttmum_ad_ad_type
-- Type: INDEX

-- Name: ix_ttmum_ad_ad_type; Type: INDEX; Schema: labmao; Owner: -
--

CREATE INDEX ix_ttmum_ad_ad_type ON labmao.labmao_ad USING btree (ad_type);


--
