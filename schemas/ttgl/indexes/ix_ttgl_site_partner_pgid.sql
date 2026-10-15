-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttgl_site_partner_pgid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_site_partner_pgid ON ttgl.ttgl_page_partner USING btree (page_id);


--
