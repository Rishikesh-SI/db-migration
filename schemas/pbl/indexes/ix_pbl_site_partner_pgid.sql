-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_site_partner_pgid
-- Type: INDEX

-- Name: ix_pbl_site_partner_pgid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_site_partner_pgid ON pbl.pbl_page_partner USING btree (page_id);


--
