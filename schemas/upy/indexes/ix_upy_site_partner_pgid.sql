-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_site_partner_pgid
-- Type: INDEX

-- Name: ix_upy_site_partner_pgid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_site_partner_pgid ON upy.upy_page_partner USING btree (page_id);


--
