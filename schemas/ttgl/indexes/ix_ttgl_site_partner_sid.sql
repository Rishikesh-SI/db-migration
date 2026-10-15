-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_site_partner_sid
-- Type: INDEX

-- Name: ix_ttgl_site_partner_sid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_site_partner_sid ON ttgl.ttgl_site_partner USING btree (site_id);


--
