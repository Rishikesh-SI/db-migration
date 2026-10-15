-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_site_partner_sid
-- Type: INDEX

-- Name: ix_pbl_site_partner_sid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_site_partner_sid ON pbl.pbl_site_partner USING btree (site_id);


--
