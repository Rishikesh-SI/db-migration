-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_unq_role_mid_aid
-- Type: INDEX

-- Name: ix_unq_role_mid_aid; Type: INDEX; Schema: dd; Owner: -
--

CREATE UNIQUE INDEX ix_unq_role_mid_aid ON dd.dd_user_role_menu_action_map2 USING btree (role_id, user_menu_id, user_action_id);


--
