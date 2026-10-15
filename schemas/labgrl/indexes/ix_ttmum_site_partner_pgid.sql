-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labgrl; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labgrl.labgrl_page_partner USING btree (page_id);


--
