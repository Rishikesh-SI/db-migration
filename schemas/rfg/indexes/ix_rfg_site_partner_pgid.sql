-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_site_partner_pgid
-- Type: INDEX

-- Name: ix_rfg_site_partner_pgid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_site_partner_pgid ON rfg.rfg_page_partner USING btree (page_id);


--
