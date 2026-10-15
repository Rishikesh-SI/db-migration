-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labhkind; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labhkind.labhkind_page_partner USING btree (page_id);


--
