-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: cli_stp_v1; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON cli_stp_v1.cli_stp_v1_page_partner USING btree (page_id);


--
