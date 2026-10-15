-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_ad_ad_type
-- Type: INDEX

-- Name: ix_ttgl_ad_ad_type; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_ad_ad_type ON ttgl.ttgl_ad USING btree (ad_type);


--
